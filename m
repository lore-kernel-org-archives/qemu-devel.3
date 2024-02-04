Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E04C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWi8V-0006he-4n; Sun, 04 Feb 2024 14:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rWi8T-0006hQ-LV
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 14:26:37 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rWi8R-0005of-JD
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 14:26:37 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e02597a0afso1046005b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707074793; x=1707679593; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=R/zIwme5BpcpdX4YMYP4no/wxHEKfhd3SkqNl6huhEg=;
 b=XQasiM4CTpGJj74FsxK9IYcYnMmH6Nc2+MAwHhuzwXgV0pSek2yv17y3r6XXALWlYE
 N5D1pNrnn9MqdXq3Fp5iccmSfBTF/w76Aty0c8p9JQ6FDkeYEbbXH/U/QSzm4061u5B9
 BoS2qXp2dUAJPvhxRSK78bhzA8IUWM/5PwJWBRM896gOQXk3Yn5kWSjBTeAaD7bGKcT3
 L0ysxJ/FnBCmConOPqDC3yZvbHsifT/ZLQxwzGW2CzPGPV3u4ediIlSf1HLnmgDViTOF
 eSr4CJxjM5tC2gTv7093wToq22EvspLSJVDUbAJJtSVgcJOzPHETDa6h71hPD/t2qA7B
 uXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707074793; x=1707679593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/zIwme5BpcpdX4YMYP4no/wxHEKfhd3SkqNl6huhEg=;
 b=oJKHk+iJNGIUCzMKKgNaE4U0Oxc1cIboQ3qKYxL+9mS225b/dDMFSFmqbWLpYxOHm3
 DrMDULTyQhODXoiYzHQEHJRq7p7kB0wMRPVrhX58fJZk4NCvvkfR5YZwUezhDG4992pg
 K/+7IyJ6dZ61IsEyVwEcm3+Gxlnh9SQgrXbUp3yV/XnTzjd+W6KEcA/txDIt4OBrSt+F
 Y5+RduqpvQ0Pu7P8l7SyB0ELWCP1FcbmlfpRg9A1e96oL4+hZmc0MTV1N75yvrBde6VP
 dwjX23mSdtl5FvxfFQpzVGqaCUWVc0/2HTjf4IEFuNdzzktBu+vJTBworE1+EMR1sToX
 Hg/g==
X-Gm-Message-State: AOJu0YyRRbQ0++DOl5wQyVs+fBpfUETDsUjIopquW+3JWKhaTi4NDRWa
 F8vfveFPJDUD+eyDBo958VFNnakf+nYC4a/X//s3hqVAc78Y+dWE
X-Google-Smtp-Source: AGHT+IGriDGMFQw6nGhYtzjnMTthfIsUXGWjcBG2lsR4HyO1JLpa9NWuEjwHsPadwMqBXF0hrua4eA==
X-Received: by 2002:a05:6a20:94c4:b0:19e:2d02:56c3 with SMTP id
 ht4-20020a056a2094c400b0019e2d0256c3mr11281584pzb.6.1707074793560; 
 Sun, 04 Feb 2024 11:26:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXvlRePcCm6hOF515UKfilBFJd8XEGEUVQi8mGlhjxQbQPgG9kg8C7BPn4ABhemNdOQ/mnFrpPIsziTMAcnhksNIvijG+D6IypBfOLiOKbZN3qQZn7XgitOgiew
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a63f404000000b005cfba3c84b7sm5531546pgi.81.2024.02.04.11.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 11:26:32 -0800 (PST)
Date: Sun, 4 Feb 2024 11:26:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 02/10] hw/hppa/machine: Disable default devices with
 --nodefaults option
Message-ID: <f7dac423-eea4-46d5-bdfd-5a1cf9a5c994@roeck-us.net>
References: <20240113055729.4480-1-deller@kernel.org>
 <20240113055729.4480-3-deller@kernel.org>
 <b907f081-5848-4441-a285-f5fca47ace14@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b907f081-5848-4441-a285-f5fca47ace14@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi Helge,

On Thu, Feb 01, 2024 at 08:22:58PM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Sat, Jan 13, 2024 at 06:57:20AM +0100, deller@kernel.org wrote:
> > From: Helge Deller <deller@gmx.de>
> > 
> > Recognize the qemu --nodefaults option, which will disable the
> > following default devices on hppa:
> > - lsi53c895a SCSI controller,
> > - artist graphics card,
> > - LASI 82596 NIC,
> > - tulip PCI NIC,
> > - second serial PCI card,
> > - USB OHCI controller.
> > 
> > Adding this option is very useful to allow manual testing and
> > debugging of the other possible devices on the command line.
> > 
> 
> With this patch in the tree, I get some interesting crashes in Seabios
> if I provide a somewhat unusual command line option. For example,
> something like
> 
>     -usb -device usb-ehci,id=ehci \
>     -device usb-uas,bus=ehci.0,id=uas \
>     -device scsi-hd,bus=uas.0,scsi-id=0,lun=0,drive=d0 \
>     -drive file= ...
> 
> is accepted as command line option but results in
> 
> SeaBIOS PA-RISC 32-bit Firmware Version 15 (QEMU 8.2.1)
> Duplex Console IO Dependent Code (IODC) revision 1
> ------------------------------------------------------------------------------
>   (c) Copyright 2017-2024 Helge Deller <deller@gmx.de> and SeaBIOS developers.
> ------------------------------------------------------------------------------
>   Processor   Speed            State           Coprocessor State  Cache Size
>   ---------  --------   ---------------------  -----------------  ----------
>       0      250 MHz    Active                 Functional            0 KB
>       1      250 MHz    Idle                   Functional            0 KB
>       2      250 MHz    Idle                   Functional            0 KB
>       3      250 MHz    Idle                   Functional            0 KB
>   Emulated machine:     HP C3700 (64-bit PA2.0) with 32-bit PDC
>   Available memory:     1024 MB
>   Good memory required: 16 MB
>   Primary boot path:    FWSCSI.0.0
>   Alternate boot path:  FWSCSI.0.0
>   Console path:         SERIAL_2.9600.8.none
>   Keyboard path:        SERIAL_2.9600.8.none
> *ERROR* in SeaBIOS-hppa-v15:
> prepare_boot_path:2898
> SeaBIOS wants SYSTEM HALT.

Just in case it matters, the following partial revert fixes the problem
for me.

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index eb78c46ff1..cc903bc323 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -346,10 +346,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     SysBusDevice *s;

     /* SCSI disk setup. */
-    if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-        lsi53c8xx_handle_legacy_cmdline(dev);
-    }
+    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+    lsi53c8xx_handle_legacy_cmdline(dev);

It seems that SeaBIOS doesn't like it if the SCSI interface is missing.

Guenter

