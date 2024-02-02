Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129F7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 18:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVxuE-00011M-5n; Fri, 02 Feb 2024 13:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rVxuC-00011D-Gd
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 13:04:48 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rVxu9-00048U-Um
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 13:04:48 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-295ff33ae32so1962425a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706897084; x=1707501884; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=l5mmH7qkPTDtFOUCjPlUvqXjPDGqCEsDRqQPK0gkh2Q=;
 b=jtlhO1dHaVcIE4fYecMu6wTpbmiCjedOfEziKK+1CCm1ViDO+WGQgVY6TdSz3T3hGb
 86Avcz2Ze5gPVVlwJAOmHK1m+PAOeG3HqqhDqIKrffWxmh3zyht2NupyTsxqRAfguTlb
 dDkjjXJb9nMt+/r+B4RJotLaM87wNFSaJqMxSbRIFzLe99f+EOZYPG/qczxS++Jd0soc
 Xq4Wcdon8i+CtidShs/bCmxo8pt6WqG1hp4VApEChf91hLXjezMMIQ2a5AtSMHJRTHOK
 bNk2CUC4CsPIZATj7/bUa+QBI20Aupkxt/JuCflSM1YF4Q/Cy/+z0Tnx0NbxSxoGUKvo
 2HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706897084; x=1707501884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5mmH7qkPTDtFOUCjPlUvqXjPDGqCEsDRqQPK0gkh2Q=;
 b=ar6FXvb/+HWK2EsnbvgdxdUPu0kYRR4Mw0mWvML+MmhW7OcNnVq0NCVfLTRBHH2VdH
 mjLlvMwV31PZsasCp0w/svi9aeUBpB2VEGqT4XpO1OG4truS77C/Mw3WJ5mVeOvxFxar
 xmbsCmj1cd+ML3IOz7WD0eXii0EiVPaQB15twlCKssMnoqhJMl/uDxRUtJglRn8tZKDo
 EjEB0U1PC6KOysQkDwtMMg11Ictt/l+BDdIHeVe9gri6gL9Wi/sFcF453WndNqD0MpUw
 FtzULtdb21KcxlmXkqZTfxizanHAHHsT9gaLoYny1QQsAQKoagSBhoZSDWIoVGJIsXGB
 btvQ==
X-Gm-Message-State: AOJu0YzSRGFQZxKgYC2AuzrIx/kKgRODh0cvrlEcwKiX5eWmOhT702aW
 1CSI56Zhj07QHh39mEzuGdefBzluLx919hDe2vOHuc5AhmBEbzUQ
X-Google-Smtp-Source: AGHT+IGVsTelseK+VxXaiV5pc/xT5rRCLRRgNkhdhPmrxF9V4cFQNNCRUyW8YVFWEfxHwc37WdysIg==
X-Received: by 2002:a17:90a:b396:b0:293:ed23:c2da with SMTP id
 e22-20020a17090ab39600b00293ed23c2damr6173996pjr.31.1706897084342; 
 Fri, 02 Feb 2024 10:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW0A3HRi2r70ASTT0ZRcLhnqUoYRps2mEvAsn4HHTjUyIOSx1TIfoJ57ZU/oG6G03kwRxA3yhqn4BQzxLDODXieYtuTbiV/Dy7hKXQc0mKJ+DkTmNhzQcmH/8FtVLNqELBWQVU=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 co9-20020a17090afe8900b0028bf79ad453sm310018pjb.21.2024.02.02.10.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 10:04:43 -0800 (PST)
Date: Fri, 2 Feb 2024 10:04:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 02/10] hw/hppa/machine: Disable default devices with
 --nodefaults option
Message-ID: <2384ab73-1907-4f63-bc98-dac5d8b3b48b@roeck-us.net>
References: <20240113055729.4480-1-deller@kernel.org>
 <20240113055729.4480-3-deller@kernel.org>
 <b907f081-5848-4441-a285-f5fca47ace14@roeck-us.net>
 <a9b2c811-f623-4cf3-ab22-99f98d2d1c55@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b2c811-f623-4cf3-ab22-99f98d2d1c55@gmx.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Feb 02, 2024 at 10:54:20AM +0100, Helge Deller wrote:
> Hi Guenter,
> 
> On 2/2/24 05:22, Guenter Roeck wrote:
> > On Sat, Jan 13, 2024 at 06:57:20AM +0100, deller@kernel.org wrote:
> > > From: Helge Deller <deller@gmx.de>
> > > 
> > > Recognize the qemu --nodefaults option, which will disable the
> > > following default devices on hppa:
> > > - lsi53c895a SCSI controller,
> > > - artist graphics card,
> > > - LASI 82596 NIC,
> > > - tulip PCI NIC,
> > > - second serial PCI card,
> > > - USB OHCI controller.
> > > 
> > > Adding this option is very useful to allow manual testing and
> > > debugging of the other possible devices on the command line.
> > > 
> > 
> > With this patch in the tree, I get some interesting crashes in Seabios
> > if I provide a somewhat unusual command line option. For example,
> > something like
> > 
> >      -usb -device usb-ehci,id=ehci \
> >      -device usb-uas,bus=ehci.0,id=uas \
> >      -device scsi-hd,bus=uas.0,scsi-id=0,lun=0,drive=d0 \
> >      -drive file= ...
> > 
> > is accepted as command line option but results in
> > 
> > SeaBIOS PA-RISC 32-bit Firmware Version 15 (QEMU 8.2.1)
> > Duplex Console IO Dependent Code (IODC) revision 1
> > ------------------------------------------------------------------------------
> >    (c) Copyright 2017-2024 Helge Deller <deller@gmx.de> and SeaBIOS developers.
> > ------------------------------------------------------------------------------
> >    Processor   Speed            State           Coprocessor State  Cache Size
> >    ---------  --------   ---------------------  -----------------  ----------
> >        0      250 MHz    Active                 Functional            0 KB
> >        1      250 MHz    Idle                   Functional            0 KB
> >        2      250 MHz    Idle                   Functional            0 KB
> >        3      250 MHz    Idle                   Functional            0 KB
> >    Emulated machine:     HP C3700 (64-bit PA2.0) with 32-bit PDC
> >    Available memory:     1024 MB
> >    Good memory required: 16 MB
> >    Primary boot path:    FWSCSI.0.0
> >    Alternate boot path:  FWSCSI.0.0
> >    Console path:         SERIAL_2.9600.8.none
> >    Keyboard path:        SERIAL_2.9600.8.none
> > *ERROR* in SeaBIOS-hppa-v15:
> > prepare_boot_path:2898
> > SeaBIOS wants SYSTEM HALT.
> > 
> > This is without --nodefaults, and it used to work. Is that intentional ?
> 
> This should now be fixed in the upcoming SeaBIOS-hppa-v16 version ("devel" branch):
> https://github.com/hdeller/seabios-hppa/tree/devel
> Could you test?

I was able to build from the 'master' branch, but 'devel' gives me

hppa64-linux-ld: target elf32-hppa-linux not found

Do you have a binary seabios image, by any chance ?

> If it doesn't work, please give me the full command line.
> 

qemu-system-hppa -M C3700 -smp 4 \
	-kernel vmlinux -no-reboot -snapshot \
	-usb -device usb-ehci,id=ehci \
	-device usb-uas,bus=ehci.0,id=uas \
	-device scsi-hd,bus=uas.0,scsi-id=0,lun=0,drive=d0 \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-append "root=/dev/sda rootwait console=ttyS0,115200" \
	-nographic -monitor null

This is with qemu 8.2.1. Note that the number of CPUs doesn't make a
difference. It turns out this also crashes/aborts immediately with
"nodefaults".

> > If I do use the --nodefaults parameter, I was unable to figure out how
> > to configure the serial console. What command line parameter(s) do I need to
> > get it ?
> 
> You need to add:
> -serial mon:stdio
> This will create a serial port if it's not yet there.
> 

And there was me trying all variants of "-device pci-serial-4x..." I could
think of ;-).

Guenter

