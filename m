Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE8C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKi8-0004ZF-CJ; Wed, 13 Mar 2024 05:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkKhz-0004X1-DY
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkKhm-0005nb-5d
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710321320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXbHzxrlp4ZOLokkxqB/yFnhNLbY3kEEJiqCwttTj9A=;
 b=Zfsszw2y+FudS19FI+0lNbKDAnItl187RQVqCYC9v25zzQwZZWdPi7DRoLZVZ9oTHlfJmC
 5tweO5g1UAHRoD1d4v83hRNgbutmuD/vnFd67gpkVHWojXxwD2JyxSpOId+3moIV3H6y5m
 Aa6MR+H0empWIQMiA1irm7+cOCUjLKI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-JMug7_4cP1ycppsLg3be0g-1; Wed, 13 Mar 2024 05:15:19 -0400
X-MC-Unique: JMug7_4cP1ycppsLg3be0g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4651c22fd2so48498966b.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 02:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710321012; x=1710925812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXbHzxrlp4ZOLokkxqB/yFnhNLbY3kEEJiqCwttTj9A=;
 b=rqp1/MekM7hfVz67srMyKtvi4cgCxJnyF+pJ6I82zZvvck9l4TZ4Crw3yi73wEkS7Y
 Wx1Nw/DY32qD6Dbj0JLc1DWI81Zsxc6cIBf3XTsTJvM07DD2MB8Bb2Wh0PX8g1d5VD54
 j7rIeVg5qTY+7LCbaz1YhfDKWKZZ0IyXhTTqju+5iktd6+ox1QzjI5P5vsZrZBAyB+6z
 ZhV8LQMrbb9Z+Pl8BbXDMjxXCK1XbcKOeBZaUxCY3Bg7Nx3kb2SlAXymHxTENc9V1bvb
 458AU1l7vrRAV5kU9aLJFiBnle+LVxHNPoVuAGwpj9CZDOLdINn1QUoUvp3P3eij9qwh
 4HzA==
X-Gm-Message-State: AOJu0YyRz+r3mDHiiu/rbTzUNlsK60WYFEow/lDuM5ozuO70EWAr1MXn
 Ze5B5L6C0AGeoTuVcSl2ZKSf4MUJAXT+W1rLY2rRKdKhWrQfrQGS34Hhd0EQIILexCFTFbEHIW4
 92p+suEa9/xiiotbtLF65tvcRw2pOigjal3sTrrIFVRVLA/Fku42Toz3W0Lxtc5o=
X-Received: by 2002:a17:907:a801:b0:a45:94bf:18e6 with SMTP id
 vo1-20020a170907a80100b00a4594bf18e6mr9919960ejc.73.1710321012020; 
 Wed, 13 Mar 2024 02:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcmOsXlLXepzkW/D1MolgeRs58A6fMItYycsgZ+1OryqseCNy/uEBX3MY7ydlnSXeulx/TAQ==
X-Received: by 2002:a17:907:a801:b0:a45:94bf:18e6 with SMTP id
 vo1-20020a170907a80100b00a4594bf18e6mr9919929ejc.73.1710321011355; 
 Wed, 13 Mar 2024 02:10:11 -0700 (PDT)
Received: from redhat.com ([85.190.233.128]) by smtp.gmail.com with ESMTPSA id
 k13-20020a1709065fcd00b00a44f0d99d58sm4637782ejv.208.2024.03.13.02.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 02:10:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:10:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/20] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Message-ID: <20240313050927-mutt-send-email-mst@kernel.org>
References: <20240312161050.2248814-1-imammedo@redhat.com>
 <20240312133056-mutt-send-email-mst@kernel.org>
 <20240313094939.7221a1ec@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313094939.7221a1ec@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Mar 13, 2024 at 09:49:39AM +0100, Igor Mammedov wrote:
> On Tue, 12 Mar 2024 13:31:39 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Mar 12, 2024 at 05:10:30PM +0100, Igor Mammedov wrote:
> > > Changelog:
> > >  v3:
> > >    * whitespace missed by checkpatch
> > >    * fix idndent in QAPI
> > >    * reorder 17/20 before 1st 'auto' can be used
> > >    * pick up acks
> > >  v2:
> > >    * QAPI style fixes (Markus Armbruster <armbru@redhat.com>)
> > >    * squash 11/19 into 10/19 (Ani Sinha <anisinha@redhat.com>)
> > >    * split '[PATCH 09/19] smbios: build legacy mode code only for 'pc' machine'
> > >      in 3 smaller patches, to make it more readable
> > >        smbios: add smbios_add_usr_blob_size() helper                                  
> > >        smbios: rename/expose structures/bitmaps used by both legacy and modern code                                                                  
> > >        smbios: build legacy mode code only for 'pc' machine
> > >    * pick up acks  
> > 
> > thanks!
> > of course this conflicts with
> > SMBIOS type 9
> > and I am trying to figure out how to resolve this again.
> 
> I'll rebase once your pull req is merged. 
> 
> > Do you ack SMBIOS type 9 btw?
> nope, and it seems it's too late do so now.

I mean if there's a big problem I can always revert after
freeze or we can apply a fixup.


> > 
> > > Windows (10) bootloader when running on top of SeaBIOS, fails to find            
> > > SMBIOSv3 entry point. Tracing it shows that it looks for v2 anchor markers       
> > > only and not v3. Tricking it into believing that entry point is found            
> > > lets Windows successfully locate and parse SMBIOSv3 tables. Whether it           
> > > will be fixed on Windows side is not clear so here goes a workaround.            
> > >                                                                                  
> > > Idea is to try build v2 tables if QEMU configuration permits,                    
> > > and fallback to v3 tables otherwise. That will mask Windows issue                
> > > form majority of users.                                                          
> > > However if VM configuration can't be described (typically large VMs)             
> > > by v2 tables, QEMU will use SMBIOSv3 and Windows will hit the issue              
> > > again. In this case complain to Microsoft and/or use UEFI instead of             
> > > SeaBIOS (requires reinstall).                                                    
> > >                                                                                  
> > > Default compat setting of smbios-entry-point-type after series                   
> > > for pc/q35 machines:                                                             
> > >   * 9.0-newer: 'auto'                                                            
> > >   * 8.1-8.2: '64'                                                                
> > >   * 8.0-older: '32'                                                              
> > >                                                                                  
> > > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        
> > > CC: imammedo@redhat.com                                                          
> > > CC: mst@redhat.com
> > > 
> > > Igor Mammedov (20):
> > >   tests: smbios: make it possible to write SMBIOS only test
> > >   tests: smbios: add test for -smbios type=11 option
> > >   tests: smbios: add test for legacy mode CLI options
> > >   smbios: cleanup smbios_get_tables() from legacy handling
> > >   smbios: get rid of smbios_smp_sockets global
> > >   smbios: get rid of smbios_legacy global
> > >   smbios: avoid mangling user provided tables
> > >   smbios: don't check type4 structures in legacy mode
> > >   smbios: add smbios_add_usr_blob_size() helper
> > >   smbios: rename/expose structures/bitmaps used by both legacy and
> > >     modern code
> > >   smbios: build legacy mode code only for 'pc' machine
> > >   smbios: handle errors consistently
> > >   smbios: get rid of global smbios_ep_type
> > >   smbios: clear smbios_type4_count before building tables
> > >   smbios: extend smbios-entry-point-type with 'auto' value
> > >   smbios: in case of entry point is 'auto' try to build v2 tables 1st
> > >   smbios: error out when building type 4 table is not possible
> > >   tests: acpi/smbios: whitelist expected blobs
> > >   pc/q35: set SMBIOS entry point type to 'auto' by default
> > >   tests: acpi: update expected SSDT.dimmpxm blob
> > > 
> > >  hw/i386/fw_cfg.h                     |   3 +-
> > >  include/hw/firmware/smbios.h         |  28 +-
> > >  hw/arm/virt.c                        |   6 +-
> > >  hw/i386/Kconfig                      |   1 +
> > >  hw/i386/fw_cfg.c                     |  14 +-
> > >  hw/i386/pc.c                         |   4 +-
> > >  hw/i386/pc_piix.c                    |   4 +
> > >  hw/i386/pc_q35.c                     |   3 +
> > >  hw/loongarch/virt.c                  |   7 +-
> > >  hw/riscv/virt.c                      |   6 +-
> > >  hw/smbios/Kconfig                    |   2 +
> > >  hw/smbios/meson.build                |   4 +
> > >  hw/smbios/smbios.c                   | 481 +++++++++++----------------
> > >  hw/smbios/smbios_legacy.c            | 185 +++++++++++
> > >  hw/smbios/smbios_legacy_stub.c       |  15 +
> > >  qapi/machine.json                    |   5 +-
> > >  tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
> > >  tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
> > >  tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
> > >  tests/qtest/bios-tables-test.c       |  81 ++++-
> > >  20 files changed, 533 insertions(+), 316 deletions(-)
> > >  create mode 100644 hw/smbios/smbios_legacy.c
> > >  create mode 100644 hw/smbios/smbios_legacy_stub.c
> > >  create mode 100644 tests/data/smbios/type11_blob
> > >  create mode 100644 tests/data/smbios/type11_blob.legacy
> > > 
> > > -- 
> > > 2.39.3  
> > 


