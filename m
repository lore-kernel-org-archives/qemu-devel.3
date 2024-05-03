Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9297C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30Y5-0004Q8-9Y; Fri, 03 May 2024 17:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1s30Y3-0004PW-Hd; Fri, 03 May 2024 17:34:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1s30Y1-0008Vn-Er; Fri, 03 May 2024 17:34:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f4551f2725so171050b3a.1; 
 Fri, 03 May 2024 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714772067; x=1715376867; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9cuB/Nzb4bHjX6ATZRWLN6DKTHAQ3nrs6TEr9bPHTk0=;
 b=alsuyA5aG3zIaZJdYbbRKa9CbHrhQX4ofCVFMIFCqe18yU0BEXmy1ey7DwZmxccDKf
 UFcM8KdzUJ14PIuV7J20K+49RfF+VBGdLrJQbNvZir9u6/sAU+T8EB4RyxNxZJkzzya4
 0VSP1z79kG47SmOnte6MrZ9h16FNVWMy7tI2SZkqwNEJWJ9WmqRg4hQI/XxDGQZa6Gl1
 wKgR5jj9V14X/aav8LexPeaMiZ7S8lDSE2TGI+ZtXMRIWmCbA9/FTkpkjbt3AktqyWrG
 V7JlsWhuFbYO2FqGcHoyt+4TL7Gb9GC9YBRA1+7uj2fJb8sDL1TlGYDdIuxjL0sej2Ie
 WGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714772067; x=1715376867;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9cuB/Nzb4bHjX6ATZRWLN6DKTHAQ3nrs6TEr9bPHTk0=;
 b=kQ5nvmACjX4PrL60poH24/cpN+g9N0dGVWkWZ+xp6fpCr9886MLHnX+atCAQ97Ap0D
 a+Pchm21CFQEj0x3v7h+4qguEaxt24yhedj1X/xu0dNYzSkQ1XI6LdJj4n4L1aPEuvAk
 fafYOwYlNS63ldTlsyKu5OR+5Ne7MjdpPKmUs4R2XdmJ6GSawVYIQQ4uHq/o4B+WTY8A
 lgFQjQiWo9wFSIggCZW8ZRyZyDOLmG6Xpk8Ft0VpjetAHl6GchLkUAt1qSpFOiKLqjsC
 sBptX+X41Ve9e0qI+GYJCzwbk/yG9LNiGIY5TGTeApTABNvtQSBDpVrf5VxEoG3kA6np
 s2OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUddxsBRC/jw/atucKI0NUjS3BMEDYgxkkf9mh1eNp0KYNhhKd1B8AmCX5yZw2/6t1Bhi8rXgz31qkdNLDRD4Vl36IkbpVPD9XPZHvZv199yLysGpuiUUNxuOk=
X-Gm-Message-State: AOJu0YxiYtNm7yUqfkyQcDKu0aBDyOpG5tLIdFyhlaWwL7C33qS/LX+8
 /kjtGzujUiiHRjFB5PcVDkZbEGPsBrYsMPfelkVXhutP1d2OHleA
X-Google-Smtp-Source: AGHT+IHpEK21vkgZxVejAH61IV3+WgOddIqlX8pmGgM5qIuK2gEzSg5kV/zHhn9LDdSOcwdMbSP+Zg==
X-Received: by 2002:a05:6a00:114d:b0:6ec:e785:98b9 with SMTP id
 b13-20020a056a00114d00b006ece78598b9mr4557687pfm.27.1714772066889; 
 Fri, 03 May 2024 14:34:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm3519065pfb.193.2024.05.03.14.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:34:26 -0700 (PDT)
Date: Fri, 3 May 2024 14:34:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v3 07/11] hw/sh4/r2d: Realize IDE controller before
 accessing it
Message-ID: <3434b32e-036a-485c-b3c2-3dd111e6152d@roeck-us.net>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208181245.96617-8-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 08, 2024 at 07:12:40PM +0100, Philippe Mathieu-Daudé wrote:
> We should not wire IRQs on unrealized device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>

qemu 9.0 fails to boot Linux from ide/ata drives with the sh4
and sh4eb emulations. Error log is as follows.

ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
ata1.00: 16384 sectors, multi 16: LBA48
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1: lost interrupt (Status 0x58)

[ and more similar errors ]

qemu command line:

qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
	-snapshot -drive file=rootfs.ext2,format=raw,if=ide \
	-append "root=/dev/sda console=ttySC1,115200 noiotrap" \
	-serial null -serial stdio -monitor null -nographic -no-reboot

Bisect points to this patch (see below). Reverting it fixes the problem.

Guenter

---
bisect log:

# bad: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 release
# good: [1600b9f46b1bd08b00fe86c46ef6dbb48cbe10d6] Update version for v8.2.0 release
git bisect start 'v9.0.0' 'v8.2.0'
# good: [62357c047a5abc6ede992159ed7c0aaaeb50617a] Merge tag 'qemu-sparc-20240213' of https://github.com/mcayland/qemu into staging
git bisect good 62357c047a5abc6ede992159ed7c0aaaeb50617a
# bad: [d65f1ed7de1559534d0a1fabca5bdd81c594c7ca] docs/acpi/bits: add some clarity and details while also improving formating
git bisect bad d65f1ed7de1559534d0a1fabca5bdd81c594c7ca
# bad: [99e1c1137b6f339be1e4b76e243ad7b7c3d3cb8c] hw/i386/pc: Populate RTC attribute directly
git bisect bad 99e1c1137b6f339be1e4b76e243ad7b7c3d3cb8c
# bad: [760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
git bisect bad 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0
# good: [f2b4a98930c122648e9dc494e49cea5dffbcc2be] target/arm: Allow access to SPSR_hyp from hyp mode
git bisect good f2b4a98930c122648e9dc494e49cea5dffbcc2be
# bad: [1a8e2f58c5dd721086284f827326b370d19ad9eb] hw/i386/q35: Use DEVICE() cast macro with PCIDevice object
git bisect bad 1a8e2f58c5dd721086284f827326b370d19ad9eb
# good: [59ae6bcddc3651b55b96c2bf05a6cd4312e46d10] hw/ppc/prep: Realize ISA bridge before accessing it
git bisect good 59ae6bcddc3651b55b96c2bf05a6cd4312e46d10
# bad: [7ed9a5f626a6c932a8c869a91e6a8b3e2029f5ef] hw/intc/grlib_irqmp: implements the multiprocessor status register
git bisect bad 7ed9a5f626a6c932a8c869a91e6a8b3e2029f5ef
# bad: [d08b7af3f7f27f6f3da8446756bf0b9352026b1d] target/sparc: Provide hint about CPUSPARCState::irq_manager member
git bisect bad d08b7af3f7f27f6f3da8446756bf0b9352026b1d
# bad: [5e37bc4997c32a1c9a6621a060462c84df9f1b8f] hw/dma: Pass parent object to i8257_dma_init()
git bisect bad 5e37bc4997c32a1c9a6621a060462c84df9f1b8f
# bad: [3c5f86a22686ef475a8259c0d8ee714f61c770c9] hw/sh4/r2d: Realize IDE controller before accessing it
git bisect bad 3c5f86a22686ef475a8259c0d8ee714f61c770c9
# good: [fc432ba0f58343c8912b80e9056315bb9bd8df92] hw/misc/macio: Realize IDE controller before accessing it
git bisect good fc432ba0f58343c8912b80e9056315bb9bd8df92
# first bad commit: [3c5f86a22686ef475a8259c0d8ee714f61c770c9] hw/sh4/r2d: Realize IDE controller before accessing it

