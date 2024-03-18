Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B357C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 05:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm5Vh-0003Gl-1I; Mon, 18 Mar 2024 01:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rm5VE-00038l-0L
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 01:25:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rm5VB-0002ie-Aa
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 01:25:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1def3340682so20754235ad.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710739535; x=1711344335; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VbVdj6D/b4iE8YW38lmRZRkiSX17/mQ8glm3MWlFbbM=;
 b=YZGUoGjDv2/GGYYikrBx6BS0m3yL+i177sMNvR0TLP0vMnyGjUxZqvE77/0yoy1GXr
 kp1yarlXXkklikShpMlvlgFbt3N2IXj01CoKTLtBfv212ShnPEXf2VTBLjoDZ+M0m71x
 Wef9VmZtvX2KVvlk2K4178EB+qa9qV8wz9/4y6JaerMHzuhg35dg0/dnwIDdlIC9D/Sl
 2jvVOudEqJopNxV4L8FHZbAceM6DiF5kD05dZEZJsk3fi0BNUmmS4Yx7O7GAz2Gk+sGZ
 0jBPjj0iHstkueAbZnrfOvYuF9MVi2LcJie3f0cpxjylmeXPxDnkNDENikc6MeCicLwJ
 naKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710739535; x=1711344335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbVdj6D/b4iE8YW38lmRZRkiSX17/mQ8glm3MWlFbbM=;
 b=gs3CHzA/kC2yp7QMNXwnfnDHTNLCFyy03olyXEUnN6Kh8xU8LFArRTI3AoOnWMWCfx
 Cnym46sHczAMUkdt/ocomDgyaYDsWGEOsUH9LumZc10sSRzBPZC7GKm+hxDt0YjUWcJT
 pXOuub61h02gyguRPio+PuwSXkV4CQkoTMvqjvnfcvJ63AHzmbjDg2SH8pTrBlOpZ79J
 Y1MvRmfp6E8nARAx+O1rGugQlLjFtnZupKIDVv+E8lFi2hNQg4QODcCMlWozMddHGRCL
 AEkynGvziCNUQ+GdcwFQErBYCeDoEFiw4XsRDcxKuR2JptzNI58hBidyQV8Q75HZlSh8
 am5w==
X-Gm-Message-State: AOJu0YzwphuAbmYImGJKGMtyVWlgpsIxPM+EVcX4fnrFjfWDAkKvUpZB
 3NYjs/UAo5DyGJE/Vgs+lym6NCCDWpNqaxF4lgyTZNq6x15cGxJQRAtspJGUmUc=
X-Google-Smtp-Source: AGHT+IHDQFug/yzUjvZl7Hs1NDJvFGIo9EfOEzYePvcYOZd0fyO6UtTgo1GL6S9ZpxjDttHNghKCsw==
X-Received: by 2002:a17:903:1249:b0:1dd:cef5:2b27 with SMTP id
 u9-20020a170903124900b001ddcef52b27mr14516341plh.1.1710739535050; 
 Sun, 17 Mar 2024 22:25:35 -0700 (PDT)
Received: from sunil-laptop ([106.51.185.90]) by smtp.gmail.com with ESMTPSA id
 n2-20020a170902e54200b001dd67d69848sm1913454plf.82.2024.03.17.22.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 22:25:34 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:55:26 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH 03/12] uefi-test-tools: Add support for python based
 build script
Message-ID: <ZffQRvmha4iUEsmO@sunil-laptop>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <a425xsrezixamz7zo6cswvgawvv3swkfem73dod5ummkpol27i@orq5xdpzond7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a425xsrezixamz7zo6cswvgawvv3swkfem73dod5ummkpol27i@orq5xdpzond7>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 15, 2024 at 03:17:19PM +0100, Gerd Hoffmann wrote:
> > +Build/bios-tables-test.%.efi:
> > +	$(PYTHON) ../../roms/edk2-build.py --config uefi-test-build.config
> 
> Adding '--match $*' will build one arch instead of all.
> 
Thanks Gerd. Good suggestion. Let me update in next revision.

Thanks,
Sunil

