Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD0FC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprSC-0001fv-F9; Thu, 28 Mar 2024 11:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rprS6-0001fJ-MD
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:14:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rprS4-0002nM-RW
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:14:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4149532da36so7728555e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711638839; x=1712243639; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vutwe9uQNhqbkQuib/VJsrR0Y5T7DY7pGtessWbxb5I=;
 b=d5MCUCwH9QQLSFW6BFkNZDBvCDUVwe1hzoFd1RvWMgebpy/GGs/9LXwGRCv0jcOzto
 4W/ApkC51dprOeujaP4SyX4xN2ITMKtO2DzPieIJ3Cl3ryCxHfDHvJHQ2IsnHLLuMwzf
 EfGrDq2xDn5hOkYJ8xGTroywZVy7A/rOR0rZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638839; x=1712243639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vutwe9uQNhqbkQuib/VJsrR0Y5T7DY7pGtessWbxb5I=;
 b=J4Nb6WOa/VioEucN2OFWTFiutMUGPx9QUTeBXzYNr/fu2i/3m46KvOOPtkKDlI6Qri
 W+/VzHmR8rV51uCgj7qjR4AYjGCcNHuCA7oenXihSZh45oxbz+Qdmm7tUXxVsk9JaK4B
 zhYJnptr9gIw6+JpcfWTzYdlDCPGEeJCDyod4a/GwPVWW8X2sLEWBE1pnkGqw4ei2SzZ
 r0l5+oF3hvcU2euU+u4HzPdJriSl9/ZgnK+RIIxLY2kxbNJPIIVj9HZNPgQTciYtooOm
 1Fc2OBp1asIm4ZfJ8wvYQOuVDPAQunbmbC3HQO5UnrNxKpGgGot3pqB7Kjj6PZo8FXS1
 Bk2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJJj8bjVAStUcSG6adJarOpKiaxb8ckmkXESUGp7aPH6e6RAO2yqnPpymf1+Az7KSZmq4vYFvyDDxEQ0S0JvRrFnLFPSs=
X-Gm-Message-State: AOJu0Yw9JrYhpQhGwNWPe6SlZ3q4+E7DKCdgt0bd956b4DCnKje/J5Ya
 fCwlt0Ehi/P/dr7NJbh3TihydONcN9AqlimvZTKPIOIL2K42S3M6vKQfhwiiIYM=
X-Google-Smtp-Source: AGHT+IGqAinQBfrXGU5/mTtpVN5DvsCj7MjTmxxo3BTpBz9VwcwzSMIjsSrbfaQrLhnH/z44soQEMQ==
X-Received: by 2002:adf:e9cf:0:b0:341:bf20:c840 with SMTP id
 l15-20020adfe9cf000000b00341bf20c840mr2502075wrn.11.1711638839070; 
 Thu, 28 Mar 2024 08:13:59 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 ea2-20020a0560000ec200b003432d79876esm1947746wrb.97.2024.03.28.08.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:13:52 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:13:51 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 19/19] hw/xen: Have most of Xen files become
 target-agnostic
Message-ID: <83ff9fec-2ac1-418f-ac76-2256d03e676e@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-20-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-20-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 14, 2023 at 03:38:15PM +0100, Philippe Mathieu-Daudé wrote:
> Previous commits re-organized the target-specific bits
> from Xen files. We can now build the common files once
> instead of per-target.
> 
> Only 4 files call libxen API (thus its CPPFLAGS):
> - xen-hvm-common.c,
> - xen_pt.c, xen_pt_graphics.c, xen_pt_msi.c
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Reworked since v1 so dropping David's R-b tag.
> ---
>  accel/xen/meson.build          |  2 +-
>  hw/block/dataplane/meson.build |  2 +-
>  hw/xen/meson.build             | 21 ++++++++++-----------
>  3 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/accel/xen/meson.build b/accel/xen/meson.build
> index 002bdb03c6..455ad5d6be 100644
> --- a/accel/xen/meson.build
> +++ b/accel/xen/meson.build
> @@ -1 +1 @@
> -specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
> +system_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
> diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
> index 025b3b061b..4d8bcb0bb9 100644
> --- a/hw/block/dataplane/meson.build
> +++ b/hw/block/dataplane/meson.build
> @@ -1,2 +1,2 @@
>  system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
> -specific_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
> +system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
> diff --git a/hw/xen/meson.build b/hw/xen/meson.build
> index d887fa9ba4..403cab49cf 100644
> --- a/hw/xen/meson.build
> +++ b/hw/xen/meson.build
> @@ -7,26 +7,25 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
>    'xen_pvdev.c',
>  ))
>  
> -system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
> +system_ss.add(when: ['CONFIG_XEN'], if_true: files(
>    'xen-operations.c',
> -))
> -
> -xen_specific_ss = ss.source_set()
> -xen_specific_ss.add(files(
>    'xen-mapcache.c',
> +))
> +system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
>    'xen-hvm-common.c',
>  ))
> +
>  if have_xen_pci_passthrough
> -  xen_specific_ss.add(files(
> +  system_ss.add(when: ['CONFIG_XEN'], if_true: files(
>      'xen-host-pci-device.c',
> -    'xen_pt.c',
>      'xen_pt_config_init.c',
> -    'xen_pt_graphics.c',
>      'xen_pt_load_rom.c',
> +  ))
> +  system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
> +    'xen_pt.c',
> +    'xen_pt_graphics.c',

How is it useful to separate those source files? In the commit
description, there's a talk about "CPPFLAGS", but having `when: [xen]`
doesn't change the flags used to build those objects, so the talk about
"CPPFLAGS" is confusing.
Second, if for some reason the dependency `xen` is false, but
`CONFIG_XEN` is true, then we wouldn't be able to build QEMU. Try
linking a binary with "xen_pt_config_init.o" but without "xen_pt.o",
that's not going to work. So even if that first source file doesn't
directly depend on the Xen libraries, it depends on "xen_pt.o" which
depends on the Xen libraries. So ultimately, I think all those source
files should have the same condition: ['CONFIG_XEN', xen].

I've only checked the xen_pt* source files, I don't know if the same
applies to "xen-operations.c" or "xen-mapcache.c".

Beside this, QEMU built with Xen support still seems to works fine, so
adding the objects to `system_ss` instead of `specific_ss` seems
alright.

Thanks,

-- 
Anthony PERARD

