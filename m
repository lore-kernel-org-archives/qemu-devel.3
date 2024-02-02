Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB402C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 04:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVl4y-0002EC-9r; Thu, 01 Feb 2024 23:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rVl4w-0002Dx-1j
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 23:23:02 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rVl4u-0004jS-7Q
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 23:23:01 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso1312333a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 20:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706847779; x=1707452579; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=dCUWVcqYC13CALChGTz+cmfEJOMpZkeq25D4xW5L4Qk=;
 b=L5ihwULoDq61n/kVn/t9tNjUhrctSxftWTWgwOYk+t1qTlEdNMytX3J9F6Dp41SwxY
 cDOFfO1aKJwOjinfohexDE/iKPA+xalnx/g2asTzvoWeA06/XtuvZwHiYd93l3OIca40
 tJdsxCPKwBDflW/DXQGZSDel3zHcyl3x8Q7ltBF2W/eG+4dS6jemyxxRs+7RAhaQt6fJ
 rJ26mK5haa0cvDM4jnEclqFNz9oY6d8gLH31iuEIQzW75Ko2E1CnH01EzkVh0DQTrCVF
 P+Fc2V13EVuIYV42BSEfC2795zju14XI8ehpZJ9ETucV2bkXzg2S8INSufqDgj/zheND
 DzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706847779; x=1707452579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCUWVcqYC13CALChGTz+cmfEJOMpZkeq25D4xW5L4Qk=;
 b=Xocq0i3R3TxIkJQZQCO/f4apReSUqzrW6nrKdMUF8BaviIItOupnyeQrpUx1FhnU1C
 zusdzNH90G5xKujAnouIYcl0A2onX6bXc2pmbLNktvN2BY+Y7wI0M2ApqsvttMlCidBz
 fq9Iyh3L3h/bb/xqpYJs9z/I+Mns9B0Iivm/u6SgZqzRx0fwjscB6ZGUq0O+seikzMHl
 H+Db2q93Ny9zgcEmIcriInx+md407FnKNa3FBQIL5BmsBQASIWPDym6R0PnxhZmaJve+
 2IsPoBa6RC631pzFkRyY/tmP8WlhapZLeDC9eHjEg9s7+UzOSk/TyNPNeUKza01IpVKf
 SLfg==
X-Gm-Message-State: AOJu0YwiHJCd4j0oyJ6leNFezbhZIUtSv1qtHVymxgTNOXrt+C1V98oU
 LIILiP2ARF5kmDNbVom3+TLULfwhK3tytcnXO05ow8n78olCCic2RlykONNN
X-Google-Smtp-Source: AGHT+IEnF0goAVxYz0nUmwm+psmhORVGLBxIVcHREIwxXZ8LVr/gXmG7NUCJIfDIPq69zztMhoVNLQ==
X-Received: by 2002:a05:6a20:3805:b0:19c:2fb5:973f with SMTP id
 p5-20020a056a20380500b0019c2fb5973fmr5500886pzf.23.1706847778742; 
 Thu, 01 Feb 2024 20:22:58 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX0UwWWApxvsVsGwb7hQ9p36p+KfY7oqPNI/oa+PEkxCG+HGEZsBBamb6YB7W4yCLmlC/Tb6nNVZQjI11hBiZqK7qUS8O+ZSj5BcGWF3y33+nxuohTQAmDAs6mH
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006dfdb672a93sm574712pfn.20.2024.02.01.20.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 20:22:57 -0800 (PST)
Date: Thu, 1 Feb 2024 20:22:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 02/10] hw/hppa/machine: Disable default devices with
 --nodefaults option
Message-ID: <b907f081-5848-4441-a285-f5fca47ace14@roeck-us.net>
References: <20240113055729.4480-1-deller@kernel.org>
 <20240113055729.4480-3-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113055729.4480-3-deller@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi,

On Sat, Jan 13, 2024 at 06:57:20AM +0100, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Recognize the qemu --nodefaults option, which will disable the
> following default devices on hppa:
> - lsi53c895a SCSI controller,
> - artist graphics card,
> - LASI 82596 NIC,
> - tulip PCI NIC,
> - second serial PCI card,
> - USB OHCI controller.
> 
> Adding this option is very useful to allow manual testing and
> debugging of the other possible devices on the command line.
> 

With this patch in the tree, I get some interesting crashes in Seabios
if I provide a somewhat unusual command line option. For example,
something like

    -usb -device usb-ehci,id=ehci \
    -device usb-uas,bus=ehci.0,id=uas \
    -device scsi-hd,bus=uas.0,scsi-id=0,lun=0,drive=d0 \
    -drive file= ...

is accepted as command line option but results in

SeaBIOS PA-RISC 32-bit Firmware Version 15 (QEMU 8.2.1)
Duplex Console IO Dependent Code (IODC) revision 1
------------------------------------------------------------------------------
  (c) Copyright 2017-2024 Helge Deller <deller@gmx.de> and SeaBIOS developers.
------------------------------------------------------------------------------
  Processor   Speed            State           Coprocessor State  Cache Size
  ---------  --------   ---------------------  -----------------  ----------
      0      250 MHz    Active                 Functional            0 KB
      1      250 MHz    Idle                   Functional            0 KB
      2      250 MHz    Idle                   Functional            0 KB
      3      250 MHz    Idle                   Functional            0 KB
  Emulated machine:     HP C3700 (64-bit PA2.0) with 32-bit PDC
  Available memory:     1024 MB
  Good memory required: 16 MB
  Primary boot path:    FWSCSI.0.0
  Alternate boot path:  FWSCSI.0.0
  Console path:         SERIAL_2.9600.8.none
  Keyboard path:        SERIAL_2.9600.8.none
*ERROR* in SeaBIOS-hppa-v15:
prepare_boot_path:2898
SeaBIOS wants SYSTEM HALT.

This is without --nodefaults, and it used to work. Is that intentional ?

If I do use the --nodefaults parameter, I was unable to figure out how
to configure the serial console. What command line parameter(s) do I need to
get it ?

Thanks,
Guenter

