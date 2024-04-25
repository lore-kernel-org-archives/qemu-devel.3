Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB61C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzw9S-0001rm-Bk; Thu, 25 Apr 2024 06:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzw9P-0001j0-Pk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzw9O-0005kc-1N
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714040179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxRJp2CeHWv4orfYqBe8iEzY4vT7sGx0TMYwicuWQt8=;
 b=VP9Az1UxL/krvO0QNp8OX4ZHqdBvbzsSM4WGRigPEqXyUkSSuttx5dQ30xbBNFS1j2DA9Q
 QaQwqcaKxg2uUxmtFQX1D2jYYhV4aLfM5UVPbryPwoV2OPIQLr8Izvbekm3CgwA96v1ZT6
 JSOPzm4U2uXe/wxFa1tLaFac5H1Hs3E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-CxLr3G5JPkGp4zN_nnnO_Q-1; Thu, 25 Apr 2024 06:16:18 -0400
X-MC-Unique: CxLr3G5JPkGp4zN_nnnO_Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51b7404fe6bso597313e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714040177; x=1714644977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxRJp2CeHWv4orfYqBe8iEzY4vT7sGx0TMYwicuWQt8=;
 b=gaWxV5FGJHmOMyjw9hWuThT4B+AiHeLBF+Ms1BMbrvQ2uXLS+/D/1MWhP6+h34o2H8
 JFI3+u7x2Flz6O6yPlo8GYtHlDLeoVx1xCmF/Rsd9+0SdS5A6ncyMCruJKyocOtfF9jD
 Ph6I+Za/ji6yVlyH5w4eW6POo0jGWKQYwPhTC1AX7MkXNo+bfsjY3AY+lNNdb+INki2g
 Zh7n232XKJ3ftG5bVtTTD57Gju1nvK1UtIA2u/J4mSpjnko7cvbig+ajnQzb7bjobH2F
 +y2I8xE3XHd7JwzvYZrYtP+VdQDjz7i/pCucVU5dJA/Fnpt6R13o55zHNhAEWUJEmm9H
 s6Xw==
X-Gm-Message-State: AOJu0YxyzrbbT8Qo/jMxExDBYBcShmx57hvj2HsCne4LwjZTBrDOzpsl
 5PnDO+id9sexySHwTua6wGBedWvGIfg/eo9DsUDu3NiMqTA/lbzuCQOS3sMoWAUqn3I0vabX4QX
 1DNO1Si247BzYSQAjkCZ7YuadCyF1SB2nvrKV7NFA5ahMGgcolf0U
X-Received: by 2002:a2e:bb83:0:b0:2d8:901f:7f45 with SMTP id
 y3-20020a2ebb83000000b002d8901f7f45mr3269946lje.13.1714040176731; 
 Thu, 25 Apr 2024 03:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI1CHedQoCsbzcS55EEi3mkF1eoRTAs51Noftkg9lJ7qv5wN0fR5nhe6SGZ2cWWbHEL0y4JQ==
X-Received: by 2002:a2e:bb83:0:b0:2d8:901f:7f45 with SMTP id
 y3-20020a2ebb83000000b002d8901f7f45mr3269925lje.13.1714040176207; 
 Thu, 25 Apr 2024 03:16:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:9e35:9594:88eb:df3e:840e])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a05600c3b1900b0041816c3049csm27038335wms.11.2024.04.25.03.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:16:15 -0700 (PDT)
Date: Thu, 25 Apr 2024 06:16:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/4] X86: Alias isa-bios area and clean up
Message-ID: <20240425061122-mutt-send-email-mst@kernel.org>
References: <20240422200625.2768-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 22, 2024 at 10:06:21PM +0200, Bernhard Beschow wrote:
> This series changes the "isa-bios" MemoryRegion to be an alias rather than a
> copy in the pflash case. This fixes issuing pflash commands in the isa-bios
> region which matches real hardware and which some real-world legacy bioses I'm
> running rely on. Furthermore, aliasing in the isa-bios area is already the
> current behavior in the bios (a.k.a. ROM) case, so this series consolidates
> behavior.
> 
> The consolidateion results in duplicate code which is resolved in the second
> half (patches 3 and 4) in this series.
> 
> Question: AFAIU, patch 2 changes the behavior for SEV-enabled guests since the
> isa-bios area is now encrypted. Does this need compat machinery or is it a
> bugfix?

When in doubt, do a compat thing.

> Testing done:
> * `make check` with qemu-system-x86_64 (QEMU 8.2.2) installed. All tests
>   including migration tests pass.
> * `make check-avocado`
> 
> Best regards,
> Bernhard
> 
> Bernhard Beschow (4):
>   hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()
>   hw/i386/pc_sysfw: Alias rather than copy isa-bios region
>   hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>   hw/i386: Consolidate isa-bios creation
> 
>  include/hw/i386/x86.h |  2 ++
>  hw/i386/pc_sysfw.c    | 38 ++++----------------------------------
>  hw/i386/x86.c         | 35 +++++++++++++++++++----------------
>  3 files changed, 25 insertions(+), 50 deletions(-)
> 
> -- 
> 2.44.0
> 


