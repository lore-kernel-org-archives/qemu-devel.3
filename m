Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30386C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKJF-0002mw-0l; Wed, 13 Mar 2024 04:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkKJ0-0002iM-U7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkKIz-0000Cy-0E
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710319783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VI5qXcQmHliVr/vkZedxJKPYii9xPvXlf7TybALd8lM=;
 b=g4c9xJFw7VakhsZPlXJ8h5Vr1XKvlcnP2BG12wAuJVHaiBoNHT620hZNkk46Ty+QAYqfvK
 3SZ5NJ0m0INhd2A0rxVIDxlxxz3D9bbGqBMA61hv5753+hPJYsL8c7WmHH8To7ZIOSZYl8
 3+9A+e7+JS6tS+QIAWjZvCUJtmO+5jc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-flrAxR6cM8mwglL9S_bTtA-1; Wed, 13 Mar 2024 04:49:42 -0400
X-MC-Unique: flrAxR6cM8mwglL9S_bTtA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d45c7efcb0so11973771fa.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710319780; x=1710924580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VI5qXcQmHliVr/vkZedxJKPYii9xPvXlf7TybALd8lM=;
 b=P4Txnfl1CeRaIobWgY7XPAXAPzBd7xcSWqTXgn7PsKeg3XWgL/b7/k7YR7mOjkXmva
 PNMo/ICIH+d8wKxkEqPd5zdWGQYUihx3GF0vVoS+vm5VkyL6+tl0MvAtPfj0+wZ5L+mb
 c4PALutDBx4qsXRZYM3hD3jlQPzxwCUzXsZu0GAvSpQhDd0EIyMpJ0ZV+vPI4tg3MAzW
 pMyjxUIVGa7wKz4vulSuKOgaSN9PxVELrCKRrVX1KDpgARKlMLHrbzNdYFj/SlmibRjX
 Z4UJ5/QEEsOMnchhIhnWL4O/sBfEq+gWqui/ZYWrB2aitGSQESDn3rymQeL3WCNJfiGA
 Jl6w==
X-Gm-Message-State: AOJu0YxUewNpOVHVectX0rDji9bTDeUMaR4YwTdqVwUPG5dvnbVqaMz2
 xGJJL8QxNptzZ7JARAZWy6ktpBsXZCWgz6vfl7czMPpTEVpCQ40M123yQ2yl14aSagY1ioIFJOZ
 8HJPxQLiwPSzm8crSUpS3wk1SRjDIjAomcFXlMwzvSdv2RDSgu3so
X-Received: by 2002:ac2:4c38:0:b0:513:1a9c:ae77 with SMTP id
 u24-20020ac24c38000000b005131a9cae77mr7331937lfq.52.1710319780755; 
 Wed, 13 Mar 2024 01:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQibgph1KiPh7vAeHyKeOyFElekIBSmNdKm3RDU2Kn8HqBdxvhS8IeOh0OSh0zs8EFDHjQeQ==
X-Received: by 2002:ac2:4c38:0:b0:513:1a9c:ae77 with SMTP id
 u24-20020ac24c38000000b005131a9cae77mr7331923lfq.52.1710319780424; 
 Wed, 13 Mar 2024 01:49:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i7-20020a5d5227000000b0033b7ce8b496sm11124748wra.108.2024.03.13.01.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 01:49:40 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:49:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/20] Workaround Windows failing to find 64bit
 SMBIOS entry point with SeaBIOS
Message-ID: <20240313094939.7221a1ec@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240312133056-mutt-send-email-mst@kernel.org>
References: <20240312161050.2248814-1-imammedo@redhat.com>
 <20240312133056-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 12 Mar 2024 13:31:39 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 12, 2024 at 05:10:30PM +0100, Igor Mammedov wrote:
> > Changelog:
> >  v3:
> >    * whitespace missed by checkpatch
> >    * fix idndent in QAPI
> >    * reorder 17/20 before 1st 'auto' can be used
> >    * pick up acks
> >  v2:
> >    * QAPI style fixes (Markus Armbruster <armbru@redhat.com>)
> >    * squash 11/19 into 10/19 (Ani Sinha <anisinha@redhat.com>)
> >    * split '[PATCH 09/19] smbios: build legacy mode code only for 'pc' machine'
> >      in 3 smaller patches, to make it more readable
> >        smbios: add smbios_add_usr_blob_size() helper                                  
> >        smbios: rename/expose structures/bitmaps used by both legacy and modern code                                                                  
> >        smbios: build legacy mode code only for 'pc' machine
> >    * pick up acks  
> 
> thanks!
> of course this conflicts with
> SMBIOS type 9
> and I am trying to figure out how to resolve this again.

I'll rebase once your pull req is merged. 

> Do you ack SMBIOS type 9 btw?
nope, and it seems it's too late do so now.

> 
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
> >                                                                                  
> > Default compat setting of smbios-entry-point-type after series                   
> > for pc/q35 machines:                                                             
> >   * 9.0-newer: 'auto'                                                            
> >   * 8.1-8.2: '64'                                                                
> >   * 8.0-older: '32'                                                              
> >                                                                                  
> > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        
> > CC: imammedo@redhat.com                                                          
> > CC: mst@redhat.com
> > 
> > Igor Mammedov (20):
> >   tests: smbios: make it possible to write SMBIOS only test
> >   tests: smbios: add test for -smbios type=11 option
> >   tests: smbios: add test for legacy mode CLI options
> >   smbios: cleanup smbios_get_tables() from legacy handling
> >   smbios: get rid of smbios_smp_sockets global
> >   smbios: get rid of smbios_legacy global
> >   smbios: avoid mangling user provided tables
> >   smbios: don't check type4 structures in legacy mode
> >   smbios: add smbios_add_usr_blob_size() helper
> >   smbios: rename/expose structures/bitmaps used by both legacy and
> >     modern code
> >   smbios: build legacy mode code only for 'pc' machine
> >   smbios: handle errors consistently
> >   smbios: get rid of global smbios_ep_type
> >   smbios: clear smbios_type4_count before building tables
> >   smbios: extend smbios-entry-point-type with 'auto' value
> >   smbios: in case of entry point is 'auto' try to build v2 tables 1st
> >   smbios: error out when building type 4 table is not possible
> >   tests: acpi/smbios: whitelist expected blobs
> >   pc/q35: set SMBIOS entry point type to 'auto' by default
> >   tests: acpi: update expected SSDT.dimmpxm blob
> > 
> >  hw/i386/fw_cfg.h                     |   3 +-
> >  include/hw/firmware/smbios.h         |  28 +-
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
> >  hw/smbios/smbios_legacy_stub.c       |  15 +
> >  qapi/machine.json                    |   5 +-
> >  tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
> >  tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
> >  tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
> >  tests/qtest/bios-tables-test.c       |  81 ++++-
> >  20 files changed, 533 insertions(+), 316 deletions(-)
> >  create mode 100644 hw/smbios/smbios_legacy.c
> >  create mode 100644 hw/smbios/smbios_legacy_stub.c
> >  create mode 100644 tests/data/smbios/type11_blob
> >  create mode 100644 tests/data/smbios/type11_blob.legacy
> > 
> > -- 
> > 2.39.3  
> 


