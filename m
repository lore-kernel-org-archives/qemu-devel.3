Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640CFC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkn2N-0005h8-9J; Thu, 14 Mar 2024 11:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkn2J-0005gH-2O
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkn2F-0004h9-2o
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710430222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZRhSjOb6dQhOk5O8fKw7Ytl7tazdmj9IgHSATEnmrY=;
 b=fDGQs0Jjcg3VDmyjlGmhP0okH5RXs5MdE9JS9vVc77jqWlx2lrgrLICyxkwyA8ZqXF5Tah
 qwIVfldHWKX4wkL60UWYWmC5RBUduUPhltIC/nBlb7nyVvTim4CfJXMAgDjyTatKhPXrmS
 sVuzKKcXq6ngvsXe5DQY0IblXZdXx6E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-71YJk0E8OrezZgKt6I_4YA-1; Thu, 14 Mar 2024 11:30:19 -0400
X-MC-Unique: 71YJk0E8OrezZgKt6I_4YA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e4397540bso625824f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710430217; x=1711035017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZRhSjOb6dQhOk5O8fKw7Ytl7tazdmj9IgHSATEnmrY=;
 b=kbBK7ShdrXTuVnZfcIF/mP8Kc5orTbNB8k5rOzqbLfGYw10smCM9CSq/Rgvm8eThBN
 Kd2lJZWguj8QevYmrThGhESplvuDI0lY+q3iJRP+rSYiipMvNU9yGij00PPehMZxM7kj
 PIM3IrilzpSiN65I3MewPw+pggZJ57DhFsUYlpFMFgHxqr82Vd4ghKekRwvzRTP8xBq4
 7/6aeK5W4sJ29C5nRcNE1REy7BqfgZZNKQd7tSn3stqtseMIBfsh+YDItsd5oGp9BmWH
 2uoJlA9UJ03Crv+BEWgiieZfeI7DWv1TZCl5xgYIhsfIyP4zIm2tbGWtHp/7diN12877
 t0rg==
X-Gm-Message-State: AOJu0YwUFcexSH3ZmlgM1NVpJprE6NupCdk0yx7XhVMwsnq66VrsbysR
 MRW1z/ds6LgV3fVCbGQKzEHMbZM+LylO32Oex6X2Fynipf9iEmEySJu8R5Xsaan+tp9ALZjy2+T
 HjgvsdQ3tDBPqRpKz78sBNN21i5/nn8Op4vlOlohRJAJt1TIKj66G
X-Received: by 2002:adf:e88c:0:b0:33e:a1e3:87b3 with SMTP id
 d12-20020adfe88c000000b0033ea1e387b3mr1621980wrm.41.1710430217367; 
 Thu, 14 Mar 2024 08:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjhcNusy09x2Gi+WFEuuHzgeCrwb4PdqceImIywpZ/PMKEtQiawnaDKyIHzGdIlDkkKdtcBQ==
X-Received: by 2002:adf:e88c:0:b0:33e:a1e3:87b3 with SMTP id
 d12-20020adfe88c000000b0033ea1e387b3mr1621949wrm.41.1710430216819; 
 Thu, 14 Mar 2024 08:30:16 -0700 (PDT)
Received: from redhat.com ([2.52.141.198]) by smtp.gmail.com with ESMTPSA id
 y13-20020a056000108d00b0033d202abf01sm981545wrw.28.2024.03.14.08.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 08:30:16 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:30:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/21] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Message-ID: <20240314112951-mutt-send-email-mst@kernel.org>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Thu, Mar 14, 2024 at 04:22:41PM +0100, Igor Mammedov wrote:
> Changelog:
>  v4:
>    * rebase on top of current master due to conflict with
>      new SMBIOS table 9 commits
>    * add extra patch with comments about obscure legacy entries counting


Thanks a lot for the quick turnaround Igor!

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
> 
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
> 
> Igor Mammedov (21):
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
>   smbios: add extra comments to smbios_get_table_legacy()
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
>  hw/smbios/smbios.c                   | 483 +++++++++++----------------
>  hw/smbios/smbios_legacy.c            | 192 +++++++++++
>  hw/smbios/smbios_legacy_stub.c       |  15 +
>  qapi/machine.json                    |   5 +-
>  tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
>  tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
>  tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
>  tests/qtest/bios-tables-test.c       |  81 ++++-
>  20 files changed, 541 insertions(+), 317 deletions(-)
>  create mode 100644 hw/smbios/smbios_legacy.c
>  create mode 100644 hw/smbios/smbios_legacy_stub.c
>  create mode 100644 tests/data/smbios/type11_blob
>  create mode 100644 tests/data/smbios/type11_blob.legacy
> 
> --
> 2.39.3


