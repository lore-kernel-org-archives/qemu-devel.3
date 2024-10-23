Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEA2D0BB43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 22:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3jmY-0006n5-Tc; Wed, 23 Oct 2024 18:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1t3jmW-0006mk-JT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:24:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1t3jmU-0006Fa-PO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:24:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e3686088c3so266441a91.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729722281; x=1730327081; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pC+N1/8qzVQ5a8mxaopwFPTQA3lN/zsinQDKMRHOmQE=;
 b=QAuRt/Ha2xzNybyr21oBmUOXTfoSMYLbMh3isUjTVVRYW/H4ZOxBuDQHdlLxzU1NUn
 ZRI71zotD6/pxNkCXh75piDXDGyEAH6vo1fqZEEjfXBa+91Y1WwE07FXfk5gwp1N0qKe
 wl59xrDGkToKYmll+hK4OuCPY3mgDPf80rSrR0eK3A1/AjFYZ8pw4QquKktstDozLt7f
 QPjaapcjuVm6TtAFCea7vpPL3veUAStFqiHgXWap2zmEEvknE3xwMy+y87ALc+huKe/p
 PJEMdX2Lcxk6WQST5trndxAQyPKWtR2bk2L9UCPCzO4s03xATbYUf5axEQ3VldavOdXR
 6CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729722281; x=1730327081;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pC+N1/8qzVQ5a8mxaopwFPTQA3lN/zsinQDKMRHOmQE=;
 b=qGw7/I5CCmUHN+pWiHBjrXdZJGLKVNi6JxeVO3+v4qLI+C3bvNIJoCXLjbkAvpC3YD
 i4iyO+2Bk7+LQmg57sQOik7AKL6J4QYgiPBkDsZmkgeXa1ShyFUwTL0sfOWJnNuMDfbv
 wA/w38zmrtmBaJ6luYYRIT1JkEWcfAp0kQgqEU4oeRcIwPWgNVRd84U9uX2ak9V/fBEy
 9y2YzOaNx9HVzGS5wqkF3Hr81cOP26qNyQPoojlGvnAKPnT7Vf8rBCdNtzA55ln4Pn0q
 ksiAIZhdu38mGU3lyPOO7hRg3qxi3xXswK4WiU8orpC3jqUC2Y9ykPFnPl93VbV0dOiI
 577g==
X-Gm-Message-State: AOJu0YxpTJLFn6AHQlAUVElvYk0lNpHTygtc71yg47N+EAPaq1iOcDRF
 mxgVZSHuNLnxzn2Qiiqp85sHTsFcLjfJb7F0kthBPeIewENsKPQRsWJRVA==
X-Google-Smtp-Source: AGHT+IG2zU9bdDkOn+yFeJfOvtIxTWqnLOlRDltCHb1xF1wppSLfAoacNUCzNtarRDp1pQNlv44QFw==
X-Received: by 2002:a17:90a:ac18:b0:2e0:cac6:15f7 with SMTP id
 98e67ed59e1d1-2e76b2007b4mr4573165a91.0.1729722280769; 
 Wed, 23 Oct 2024 15:24:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e77e4ca3fcsm13695a91.13.2024.10.23.15.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 15:24:39 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:24:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v42 51/98] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID
 handlers (CMD9 & CMD10)
Message-ID: <94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-52-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628070216.92609-52-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Fri, Jun 28, 2024 at 09:01:27AM +0200, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---

This patch results in:

[    5.976133] Waiting for root device /dev/mmcblk0...
[    6.501462] mmc0: error -38 whilst initialising SD card
[    7.557473] mmc0: error -38 whilst initialising SD card

... (repeated until session is aborted)

when trying to boot Linux for sifive_u from sd card.
The command used to boot the image is

qemu-system-riscv64 -M sifive_u -m 512M -no-reboot \
    -kernel arch/riscv/boot/Image \
    -snapshot -drive file=rootfs.ext2,format=raw,if=sd \
    -bios default \
    -append "root=/dev/mmcblk0 rootwait console=ttySIF0,115200 earlycon" \
    -nographic -monitor none

Bisect log is attached.

Guenter

---
# bad: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 release
# good: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 release
git bisect start 'HEAD' 'v9.0.0'
# good: [2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219] hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
git bisect good 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
# bad: [76e375fc3c538bd6e4232314f693b56536a50b73] docs/qapidoc: add QMP highlighting to annotated qmp-example blocks
git bisect bad 76e375fc3c538bd6e4232314f693b56536a50b73
# good: [720c0f3e6cf856fa62c06a8f0005d814684c30d9] hw/sd/sdcard: Register generic optional handlers (CMD11 and CMD20)
git bisect good 720c0f3e6cf856fa62c06a8f0005d814684c30d9
# bad: [5915139aba1646220630596de30c673528e047c9] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
git bisect bad 5915139aba1646220630596de30c673528e047c9
# bad: [188569c10d5dc6996bde90ce25645083e9661ecb] target/i386/SEV: implement mask_cpuid_features
git bisect bad 188569c10d5dc6996bde90ce25645083e9661ecb
# bad: [8442e1625ba6723bee2c6d0fdb7207a3e27a2b05] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
git bisect bad 8442e1625ba6723bee2c6d0fdb7207a3e27a2b05
# bad: [96f3d00ac1680f978984314d24ae6f2f6f281fdc] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
git bisect bad 96f3d00ac1680f978984314d24ae6f2f6f281fdc
# good: [1ec3cb893fa8883f5baf69850a4d0a97502bbad8] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
git bisect good 1ec3cb893fa8883f5baf69850a4d0a97502bbad8
# bad: [9318be060506be33a0fbf01198b0024fdeb28f39] hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler (CMD15)
git bisect bad 9318be060506be33a0fbf01198b0024fdeb28f39
# bad: [030897e89d3dff8ef7efd5cc570612da4476734f] hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler (CMD12)
git bisect bad 030897e89d3dff8ef7efd5cc570612da4476734f
# bad: [da954d0e32444f122a41c24948d4d1c718bf66d4] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
git bisect bad da954d0e32444f122a41c24948d4d1c718bf66d4
# first bad commit: [da954d0e32444f122a41c24948d4d1c718bf66d4] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)

