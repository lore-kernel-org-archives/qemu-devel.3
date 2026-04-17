Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AB3F43691
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhH1-0004tH-9T; Fri, 17 Apr 2026 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDhGz-0004t8-UE
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDhGw-0002Yc-SV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776424925;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ad7wYG7iWlS7oiOYoKXAGe327bvoZnsdkiX2SfP56a4=;
 b=bGgcEr88+zmXbTlzu0FKVALpUzc0Bdh+oxn9fip//dKAsYQzE/B13KEqF2t2KWFh9Uk6wy
 DvNr3+AqTxOE4Epy4cfsySM6Kn3VCOw6/jEhnUXpPSImcakJKUzyQdqLj/QwLcXURqiGPC
 Ed7+VC3pC7nQJdMEHHj3vQ8Xty6FCaA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-YKAOhU17NdiHZC8kdlhESQ-1; Fri,
 17 Apr 2026 07:22:01 -0400
X-MC-Unique: YKAOhU17NdiHZC8kdlhESQ-1
X-Mimecast-MFC-AGG-ID: YKAOhU17NdiHZC8kdlhESQ_1776424920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F4219560AB; Fri, 17 Apr 2026 11:22:00 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EC330001A4; Fri, 17 Apr 2026 11:21:58 +0000 (UTC)
Date: Fri, 17 Apr 2026 12:21:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH 5/7] MAINTAINERS: Remove PhilMD from firmware sections
Message-ID: <aeIX04mdLTtRsOWO@redhat.com>
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417110550.70068-6-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 17, 2026 at 01:05:47PM +0200, Philippe Mathieu-Daudé wrote:
> I'm not paid to support this code. I haven't followed
> it neither, so be fair and just remove myself.
> Demote the status to 'Odd Fixes'.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5e766ca6c9..df8413c79e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2837,9 +2837,8 @@ F: hw/usb/vt82c686-uhci-pci.c
>  F: include/hw/isa/vt82c686.h
>  
>  Firmware configuration (fw_cfg)
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
>  R: Gerd Hoffmann <kraxel@redhat.com>
> -S: Supported
> +S: Odd Fixes

Gerd is only "R", so shoudln't this be "Orphaned" ?

>  F: docs/specs/fw_cfg.rst
>  F: hw/nvram/fw_cfg*.c
>  F: stubs/fw_cfg.c
> @@ -3955,14 +3954,12 @@ F: docs/specs/fsi.rst
>  F: tests/qtest/aspeed_fsi-test.c
>  
>  Firmware schema specifications
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
>  R: Daniel P. Berrange <berrange@redhat.com>
>  R: Kashyap Chamarthy <kchamart@redhat.com>
>  S: Maintained
>  F: docs/interop/firmware.json

Likewise only 'R' entries are left, so "Orphaned".

That said, I don't mind being listed as a maintainer
here if we call it "Odd fixes".

>  
>  EDK2 Firmware
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>  F: hw/i386/*ovmf*
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


